-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_poll_response rfg_poll_response_id
-- Type: CONSTRAINT

-- Name: rfg_poll_response rfg_poll_response_id; Type: CONSTRAINT; Schema: rfg; Owner: -
--

ALTER TABLE ONLY rfg.rfg_poll_response
    ADD CONSTRAINT rfg_poll_response_id PRIMARY KEY (poll_response_id);


--
