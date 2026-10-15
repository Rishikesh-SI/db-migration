-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_user_activity_aatid
-- Type: INDEX

-- Name: ix_user_activity_aatid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_user_activity_aatid ON khi.khi_user_activity USING btree (asset_id, asset_type_id);


--
