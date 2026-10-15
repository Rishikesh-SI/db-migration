-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_author_action_aatid
-- Type: INDEX

-- Name: ix_mum_author_action_aatid; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_author_action_aatid ON tmmimg_upd.tmmimg_upd_author_action USING btree (asset_id, asset_type_id);


--
