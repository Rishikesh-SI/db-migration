-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_user_activity_aatid
-- Type: INDEX

-- Name: ix_mum_user_activity_aatid; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_user_activity_aatid ON tmmimg_upd.tmmimg_upd_user_activity USING btree (asset_id, asset_type_id);


--
