-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: idxwp_postmeta_post_id
-- Type: INDEX

-- Name: idxwp_postmeta_post_id; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX idxwp_postmeta_post_id ON tfa.wp_postmeta USING btree (post_id);


--
