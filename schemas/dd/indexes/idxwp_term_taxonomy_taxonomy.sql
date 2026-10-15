-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: idxwp_term_taxonomy_taxonomy
-- Type: INDEX

-- Name: idxwp_term_taxonomy_taxonomy; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX idxwp_term_taxonomy_taxonomy ON dd.wp_term_taxonomy USING btree (taxonomy);


--
