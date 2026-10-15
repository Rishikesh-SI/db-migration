-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: idxwp_terms_slug
-- Type: INDEX

-- Name: idxwp_terms_slug; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX idxwp_terms_slug ON gsf.wp_terms USING btree (slug);


--
