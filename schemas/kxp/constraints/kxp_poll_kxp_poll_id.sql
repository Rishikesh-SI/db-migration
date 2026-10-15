-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: kxp_poll kxp_poll_id
-- Type: CONSTRAINT

-- Name: kxp_poll kxp_poll_id; Type: CONSTRAINT; Schema: kxp; Owner: -
--

ALTER TABLE ONLY kxp.kxp_poll
    ADD CONSTRAINT kxp_poll_id PRIMARY KEY (poll_id);


--
