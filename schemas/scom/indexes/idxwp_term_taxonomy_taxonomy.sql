-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: idxwp_term_taxonomy_taxonomy
-- Type: INDEX

-- Name: idxwp_term_taxonomy_taxonomy; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX idxwp_term_taxonomy_taxonomy ON scom.wp_term_taxonomy USING btree (taxonomy);


--
