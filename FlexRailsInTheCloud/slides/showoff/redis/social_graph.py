# See http://forrst.com/posts/Social_Graphing_with_Redis_Sets_and_Python-Rkd
#EDIT rewrote the docstrings, brevity is better.

import redis

class Socialgraph:
    """
    Basic class used to manipulate a Socal Graph built with sets,
    directed graphs and Redis.
    This class will allow you to do silly things like self referential
    nodes (node a follows node a). Input integrity is for another day.
    """
    def __init__(self, db):
        "Instantiate the class by passing a Redis connection"
        self.db = db
        # you should probably not do this, make the connection in
        # its own manager class or at the very least check if it
        # actually is a redis object:
        #   e.g. self.db.ping() should return PONG.

    def follow(self, a, b):
        """
        Add a relationship to the graph, ``a`` is following ``b``
        and ``b`` is followed by ``a``. Returns a boolean indicating
        if the transaction was successful.
        """
        x = self.db.sadd(("node:%s:following" % a), b)
        y = self.db.sadd(("node:%s:followers" % b), a)
        return True if x + y == 2 else False

    def unfollow(self, a, b):
        """
        Remove a relationship from the graph, ``a`` unfollows ``b``
        and ``a`` is unfollowed by ``b``. Returns a boolean indicating
        if the transaction was successful.
        """
        x = self.db.srem(("node:%s:following" % a), b)
        y = self.db.srem(("node:%s:followers" % b), a)
        return True if x + y == 2 else False

    def following(self, a):
        "Return a set of nodes ``a`` follows."
        return self.db.smembers("node:%s:following" % a)

    def followers(self, a):
        "Return a set of nodes that follow ``a``."
        return self.db.smembers("node:%s:followers" % a)

    def friends(self, a):
        "Return a set of nodes mutually related to ``a``."
        return self.db.sinter(["node:%s:following" % a,
            "node:%s:followers" % a])

    def followingCount(self, a):
        "Return a count of nodes ``a`` follows."
        return self.db.scard("node:%s:following" % a)

    def followersCount(self, a):
        "Return a count of nodes that follow ``a``."
        return self.db.scard("node:%s:followers" % a)

    def friendsCount(self, a):
        "Return a count of nodes mutually related to ``a``."
        return len(self.friends(a))

    def isFollowing(self, a, b):
        "Return a boolean indicating if ``a`` is following ``b``."
        return self.db.sismember(("node:%s:following" % a), b)


# Test

def test():
    # 3 users
    # 1 follows 2
    # 2 follows 1
    # 2 follows 3
    # 3 follows 2
    db = redis.Redis(host='localhost', port=6379, db=0)
    g = Socialgraph(db)
    print
    print "node connections"
    print "True, %s" % g.follow(1, 2)
    print "True, %s" % g.follow(2, 1)
    print "True, %s" % g.follow(2, 3)
    print "True, %s" % g.follow(3, 2)
    print
    print "who am I following?"
    print "[2], %s" % g.following(1)
    print "[1, 3], %s" % g.following(2)
    print "[2], %s" % g.following(3)
    print
    print "who are my followers?"
    print "[2], %s" % g.followers(1)
    print "[1, 3], %s" % g.followers(2)
    print "[2], %s" % g.followers(3)
    print
    print "who are my friends?"
    print "[2], %s" % g.friends(1)
    print "[1, 3], %s" % g.friends(2)
    print "[2], %s" % g.friends(3)
    print
    print "following count"
    print "1, %s" % g.followingCount(1)
    print "2, %s" % g.followingCount(2)
    print "1, %s" % g.followingCount(3)
    print
    print "followers count"
    print "1, %s" % g.followersCount(1)
    print "2, %s" % g.followersCount(2)
    print "1, %s" % g.followersCount(3)
    print
    print "friend count"
    print "1, %s" % g.friendsCount(1)
    print "2, %s" % g.friendsCount(2)
    print "1, %s" % g.friendsCount(3)
    print
    print "oh hai, 4 has joined the party"
    print
    print "True, %s" % g.follow(4, 1)
    print "True, %s" % g.follow(4, 2)
    print
    print "repeat tests, with user 4 added"
    print
    print "who am I following?"
    print "[2], %s" % g.following(1)
    print "[1, 3], %s" % g.following(2)
    print "[2], %s" % g.following(3)
    print "[1, 2], %s" % g.following(4)
    print
    print "who are my followers?"
    print "[2, 4], %s" % g.followers(1)
    print "[1, 3, 4], %s" % g.followers(2)
    print "[2], %s" % g.followers(3)
    print "[], %s" % g.followers(4)
    print
    print "who are my friends?"
    print "[2], %s" % g.friends(1)
    print "[1, 3], %s" % g.friends(2)
    print "[2], %s" % g.friends(3)
    print "[], %s" % g.friends(4)
    print
    print "following count"
    print "1, %s" % g.followingCount(1)
    print "2, %s" % g.followingCount(2)
    print "1, %s" % g.followingCount(3)
    print "2, %s" % g.followingCount(4)
    print
    print "followers count"
    print "2, %s" % g.followersCount(1)
    print "3, %s" % g.followersCount(2)
    print "1, %s" % g.followersCount(3)
    print "0, %s" % g.followersCount(4)
    print
    print "friend count"
    print "1, %s" % g.friendsCount(1)
    print "2, %s" % g.friendsCount(2)
    print "1, %s" % g.friendsCount(3)
    print "0, %s" % g.friendsCount(4)
    print
    print "the bustup"
    print
    print "True, %s" % g.unfollow(1, 2)
    print "True, %s" % g.unfollow(2, 1)
    print
    print "who am I following?"
    print "[], %s" % g.following(1)
    print "[3], %s" % g.following(2)
    print "[2], %s" % g.following(3)
    print "[1, 2], %s" % g.following(4)
    print
    print "who are my followers?"
    print "[4], %s" % g.followers(1)
    print "[3, 4], %s" % g.followers(2)
    print "[2], %s" % g.followers(3)
    print "[], %s" % g.followers(4)
    print
    print "who are my friends?"
    print "[], %s" % g.friends(1)
    print "[3], %s" % g.friends(2)
    print "[2], %s" % g.friends(3)
    print "[], %s" % g.friends(4)
    print
    print "following count"
    print "0, %s" % g.followingCount(1)
    print "1, %s" % g.followingCount(2)
    print "1, %s" % g.followingCount(3)
    print "2, %s" % g.followingCount(4)
    print
    print "followers count"
    print "1, %s" % g.followersCount(1)
    print "2, %s" % g.followersCount(2)
    print "1, %s" % g.followersCount(3)
    print "0, %s" % g.followersCount(4)
    print
    print "friend count"
    print "0, %s" % g.friendsCount(1)
    print "1, %s" % g.friendsCount(2)
    print "1, %s" % g.friendsCount(3)
    print "0, %s" % g.friendsCount(4)
    print
    print "nosey, nosey"
    print
    print "am I following"
    print "False, %s" % g.isFollowing(1, 2)
    print "False, %s" % g.isFollowing(1, 2)
    print "False, %s" % g.isFollowing(1, 3)
    print "False, %s" % g.isFollowing(2, 1)
    print "True, %s" % g.isFollowing(2, 3)
    print "False, %s" % g.isFollowing(2, 4)
    print "False, %s" % g.isFollowing(3, 1)
    print "True, %s" % g.isFollowing(3, 2)
    print "False, %s" % g.isFollowing(3, 4)
    print "True, %s" % g.isFollowing(4, 1)
    print "True, %s" % g.isFollowing(4, 2)
    print "False, %s" % g.isFollowing(4, 4)
    print
    db.flushdb()

test()