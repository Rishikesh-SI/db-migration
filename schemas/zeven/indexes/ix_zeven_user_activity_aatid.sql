-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_user_activity_aatid
-- Type: INDEX

-- Name: ix_zeven_user_activity_aatid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_user_activity_aatid ON zeven.zeven_user_activity USING btree (asset_id, asset_type_id);


--
