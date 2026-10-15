-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: idxwp_term_taxonomy_taxonomy
-- Type: INDEX

-- Name: idxwp_term_taxonomy_taxonomy; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX idxwp_term_taxonomy_taxonomy ON swa.wp_term_taxonomy USING btree (taxonomy);


--
