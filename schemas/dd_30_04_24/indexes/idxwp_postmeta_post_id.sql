-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: idxwp_postmeta_post_id
-- Type: INDEX

-- Name: idxwp_postmeta_post_id; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX idxwp_postmeta_post_id ON dd_30_04_24.wp_postmeta USING btree (post_id);


--
