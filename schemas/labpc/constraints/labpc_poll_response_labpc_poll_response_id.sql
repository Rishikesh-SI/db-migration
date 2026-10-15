-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_poll_response labpc_poll_response_id
-- Type: CONSTRAINT

-- Name: labpc_poll_response labpc_poll_response_id; Type: CONSTRAINT; Schema: labpc; Owner: -
--

ALTER TABLE ONLY labpc.labpc_poll_response
    ADD CONSTRAINT labpc_poll_response_id PRIMARY KEY (poll_response_id);


--
