-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_user_asset_reactio_asset_id_asset_type_id_user_i_idx
-- Type: INDEX

-- Name: labbsc_dev_user_asset_reactio_asset_id_asset_type_id_user_i_idx; Type: INDEX; Schema: labbsc_dev; Owner: -
--

CREATE INDEX labbsc_dev_user_asset_reactio_asset_id_asset_type_id_user_i_idx ON labbsc_dev.labbsc_dev_user_asset_reaction USING btree (asset_id, asset_type_id, user_id, parent_comment_id NULLS FIRST);


--
