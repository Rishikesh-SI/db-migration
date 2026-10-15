-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: idxwp_term_taxonomy_taxonomy
-- Type: INDEX

-- Name: idxwp_term_taxonomy_taxonomy; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX idxwp_term_taxonomy_taxonomy ON tfa.wp_term_taxonomy USING btree (taxonomy);


--
