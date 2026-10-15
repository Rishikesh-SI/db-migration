-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: ix_ttmum_user_activity_aatid
-- Type: INDEX

-- Name: ix_ttmum_user_activity_aatid; Type: INDEX; Schema: labisp; Owner: -
--

CREATE INDEX ix_ttmum_user_activity_aatid ON labisp.labisp_user_activity USING btree (asset_id, asset_type_id);


--
