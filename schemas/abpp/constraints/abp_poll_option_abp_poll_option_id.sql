-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_poll_option abp_poll_option_id
-- Type: CONSTRAINT

-- Name: abp_poll_option abp_poll_option_id; Type: CONSTRAINT; Schema: abpp; Owner: -
--

ALTER TABLE ONLY abpp.abp_poll_option
    ADD CONSTRAINT abp_poll_option_id PRIMARY KEY (poll_option_id);


--
