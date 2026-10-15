-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_page_alias
-- Type: INDEX

-- Name: ix_pcm_page_alias; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_page_alias ON pcm.pcm_page USING btree (alias);


--
