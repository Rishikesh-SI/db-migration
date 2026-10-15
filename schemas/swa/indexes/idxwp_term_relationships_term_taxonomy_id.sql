-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: idxwp_term_relationships_term_taxonomy_id
-- Type: INDEX

-- Name: idxwp_term_relationships_term_taxonomy_id; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX idxwp_term_relationships_term_taxonomy_id ON swa.wp_term_relationships USING btree (term_taxonomy_id);


--
