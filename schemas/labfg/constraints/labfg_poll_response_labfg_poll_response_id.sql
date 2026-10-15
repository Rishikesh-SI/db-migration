-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: labfg_poll_response labfg_poll_response_id
-- Type: CONSTRAINT

-- Name: labfg_poll_response labfg_poll_response_id; Type: CONSTRAINT; Schema: labfg; Owner: -
--

ALTER TABLE ONLY labfg.labfg_poll_response
    ADD CONSTRAINT labfg_poll_response_id PRIMARY KEY (poll_response_id);


--
