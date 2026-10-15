-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_poll_response_roid
-- Type: INDEX

-- Name: ix_jafc_poll_response_roid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_poll_response_roid ON jafc.jafc_poll_response USING btree (response_option_id);


--
