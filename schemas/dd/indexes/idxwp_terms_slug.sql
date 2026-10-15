-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: idxwp_terms_slug
-- Type: INDEX

-- Name: idxwp_terms_slug; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX idxwp_terms_slug ON dd.wp_terms USING btree (slug);


--
