-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: uar_aat_view_idx
-- Type: INDEX

-- Name: uar_aat_view_idx; Type: INDEX; Schema: labdms; Owner: -
--

CREATE INDEX uar_aat_view_idx ON labdms.labyho_asset_comment_count_view USING btree (asset_id, asset_type_id);


--
