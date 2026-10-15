-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_site_partner_sid
-- Type: INDEX

-- Name: ix_pcm_site_partner_sid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_site_partner_sid ON pcm.pcm_site_partner USING btree (site_id);


--
