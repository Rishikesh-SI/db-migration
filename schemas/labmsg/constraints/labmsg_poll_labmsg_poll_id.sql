-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_poll labmsg_poll_id
-- Type: CONSTRAINT

-- Name: labmsg_poll labmsg_poll_id; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_poll
    ADD CONSTRAINT labmsg_poll_id PRIMARY KEY (poll_id);


--
