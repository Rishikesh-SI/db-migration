-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_user_activity_aatid
-- Type: INDEX

-- Name: ix_tcs_user_activity_aatid; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_user_activity_aatid ON tcs.tcs_user_activity USING btree (asset_id, asset_type_id);


--
