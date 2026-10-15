-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_article_asset_map_article_id_idx
-- Type: INDEX

-- Name: lablsg_article_asset_map_article_id_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_article_asset_map_article_id_idx ON fanxp_lsg.lablsg_article_asset_map USING btree (article_id);


--
