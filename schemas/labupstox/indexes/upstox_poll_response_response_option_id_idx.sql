-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: upstox_poll_response_response_option_id_idx
-- Type: INDEX

-- Name: upstox_poll_response_response_option_id_idx; Type: INDEX; Schema: labupstox; Owner: -
--

CREATE INDEX upstox_poll_response_response_option_id_idx ON labupstox.labupstox_poll_response USING btree (response_option_id);


--
