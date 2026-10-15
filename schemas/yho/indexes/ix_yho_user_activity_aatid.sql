-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_user_activity_aatid
-- Type: INDEX

-- Name: ix_yho_user_activity_aatid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_user_activity_aatid ON yho.yho_user_activity USING btree (asset_id, asset_type_id);


--
