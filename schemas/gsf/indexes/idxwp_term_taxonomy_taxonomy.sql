-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: idxwp_term_taxonomy_taxonomy
-- Type: INDEX

-- Name: idxwp_term_taxonomy_taxonomy; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX idxwp_term_taxonomy_taxonomy ON gsf.wp_term_taxonomy USING btree (taxonomy);


--
