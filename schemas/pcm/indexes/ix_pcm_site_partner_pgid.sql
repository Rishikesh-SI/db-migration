-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_site_partner_pgid
-- Type: INDEX

-- Name: ix_pcm_site_partner_pgid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_site_partner_pgid ON pcm.pcm_page_partner USING btree (page_id);


--
