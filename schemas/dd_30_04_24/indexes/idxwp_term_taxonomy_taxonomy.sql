-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: idxwp_term_taxonomy_taxonomy
-- Type: INDEX

-- Name: idxwp_term_taxonomy_taxonomy; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX idxwp_term_taxonomy_taxonomy ON dd_30_04_24.wp_term_taxonomy USING btree (taxonomy);


--
