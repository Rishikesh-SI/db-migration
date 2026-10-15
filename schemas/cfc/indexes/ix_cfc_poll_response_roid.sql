-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_poll_response_roid
-- Type: INDEX

-- Name: ix_cfc_poll_response_roid; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_poll_response_roid ON cfc.cfc_poll_response USING btree (response_option_id);


--
