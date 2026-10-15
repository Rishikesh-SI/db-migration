-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_user_activity_aatid
-- Type: INDEX

-- Name: ix_abp_user_activity_aatid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_user_activity_aatid ON abpp.abp_user_activity USING btree (asset_id, asset_type_id);


--
