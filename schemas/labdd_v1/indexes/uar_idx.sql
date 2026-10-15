-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: uar_idx
-- Type: INDEX

-- Name: uar_idx; Type: INDEX; Schema: labdd_v1; Owner: -
--

CREATE INDEX uar_idx ON labdd_v1.labdd_v1_user_asset_reaction USING btree (asset_id, asset_type_id, user_id, parent_comment_id NULLS FIRST);


--
