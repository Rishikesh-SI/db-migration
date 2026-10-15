-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: uar_index_2
-- Type: INDEX

-- Name: uar_index_2; Type: INDEX; Schema: labyho; Owner: -
--

CREATE UNIQUE INDEX uar_index_2 ON labyho.labyho_asset_comment_reaction_dk USING btree (asset_id, asset_type_id, user_id, comment_id);


--
