-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: uar_index_7
-- Type: INDEX

-- Name: uar_index_7; Type: INDEX; Schema: labyho; Owner: -
--

CREATE INDEX uar_index_7 ON labyho.labyho_user_asset_reaction_dk USING btree (asset_id, asset_type_id, user_id, reaction_id);


--
