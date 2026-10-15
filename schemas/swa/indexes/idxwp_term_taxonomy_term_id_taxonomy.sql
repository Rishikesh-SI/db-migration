-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: idxwp_term_taxonomy_term_id_taxonomy
-- Type: INDEX

-- Name: idxwp_term_taxonomy_term_id_taxonomy; Type: INDEX; Schema: swa; Owner: -
--

CREATE UNIQUE INDEX idxwp_term_taxonomy_term_id_taxonomy ON swa.wp_term_taxonomy USING btree (term_id, taxonomy);


--
