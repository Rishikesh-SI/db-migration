-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_user_activity_aatid
-- Type: INDEX

-- Name: ix_user_activity_aatid; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_user_activity_aatid ON dd.dd_user_activity USING btree (asset_id, asset_type_id);


--
