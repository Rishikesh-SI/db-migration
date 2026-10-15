-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_redirect labmsg_redirect_id
-- Type: CONSTRAINT

-- Name: labmsg_redirect labmsg_redirect_id; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_redirect
    ADD CONSTRAINT labmsg_redirect_id PRIMARY KEY (redirect_id);


--
