-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: ix_pkl_poll_response_roid
-- Type: INDEX

-- Name: ix_pkl_poll_response_roid; Type: INDEX; Schema: pkl; Owner: -
--

CREATE INDEX ix_pkl_poll_response_roid ON pkl.pkl_poll_response USING btree (response_option_id);


--
