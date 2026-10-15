-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ppb_poll_option ppb_poll_option_id
-- Type: CONSTRAINT

-- Name: ppb_poll_option ppb_poll_option_id; Type: CONSTRAINT; Schema: ppb; Owner: -
--

ALTER TABLE ONLY ppb.ppb_poll_option
    ADD CONSTRAINT ppb_poll_option_id PRIMARY KEY (poll_option_id);


--
