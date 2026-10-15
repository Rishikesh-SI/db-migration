-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: idxwp_postmeta_post_id
-- Type: INDEX

-- Name: idxwp_postmeta_post_id; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX idxwp_postmeta_post_id ON gsf.wp_postmeta USING btree (post_id);


--
