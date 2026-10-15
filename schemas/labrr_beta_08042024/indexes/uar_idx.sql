-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: uar_idx
-- Type: INDEX

-- Name: uar_idx; Type: INDEX; Schema: labrr_beta_08042024; Owner: -
--

CREATE INDEX uar_idx ON labrr_beta_08042024.labrr_user_asset_reaction USING btree (asset_id, asset_type_id, user_id, parent_comment_id NULLS FIRST);


--
