-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_poll_response_roid
-- Type: INDEX

-- Name: ix_mum_poll_response_roid; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_poll_response_roid ON tmmimg_upd.tmmimg_upd_poll_response USING btree (response_option_id);


--
