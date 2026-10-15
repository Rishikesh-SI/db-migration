-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_poll_response_response_option_id_idx
-- Type: INDEX

-- Name: labwf_poll_response_response_option_id_idx; Type: INDEX; Schema: fanxp_wf; Owner: -
--

CREATE INDEX labwf_poll_response_response_option_id_idx ON fanxp_wf.labwf_poll_response USING btree (response_option_id);


--
