-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: uar_idx
-- Type: INDEX

-- Name: uar_idx; Type: INDEX; Schema: labrstg; Owner: -
--

CREATE INDEX uar_idx ON labrstg.labrstg_user_asset_reaction USING btree (asset_id, asset_type_id, user_id, parent_comment_id NULLS FIRST);


--
