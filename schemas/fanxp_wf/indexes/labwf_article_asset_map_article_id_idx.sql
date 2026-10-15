-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_article_asset_map_article_id_idx
-- Type: INDEX

-- Name: labwf_article_asset_map_article_id_idx; Type: INDEX; Schema: fanxp_wf; Owner: -
--

CREATE INDEX labwf_article_asset_map_article_id_idx ON fanxp_wf.labwf_article_asset_map USING btree (article_id);


--
