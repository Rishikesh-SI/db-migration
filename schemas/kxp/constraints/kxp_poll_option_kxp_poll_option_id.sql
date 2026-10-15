-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: kxp_poll_option kxp_poll_option_id
-- Type: CONSTRAINT

-- Name: kxp_poll_option kxp_poll_option_id; Type: CONSTRAINT; Schema: kxp; Owner: -
--

ALTER TABLE ONLY kxp.kxp_poll_option
    ADD CONSTRAINT kxp_poll_option_id PRIMARY KEY (poll_option_id);


--
