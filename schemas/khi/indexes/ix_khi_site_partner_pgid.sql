-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_khi_site_partner_pgid
-- Type: INDEX

-- Name: ix_khi_site_partner_pgid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_khi_site_partner_pgid ON khi.khi_page_partner USING btree (page_id);


--
