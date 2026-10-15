-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: ix_upp_site_partner_pgid
-- Type: INDEX

-- Name: ix_upp_site_partner_pgid; Type: INDEX; Schema: utt; Owner: -
--

CREATE INDEX ix_upp_site_partner_pgid ON utt.utt_page_partner USING btree (page_id);


--
