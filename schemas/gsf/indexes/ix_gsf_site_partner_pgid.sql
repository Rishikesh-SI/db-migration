-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_site_partner_pgid
-- Type: INDEX

-- Name: ix_gsf_site_partner_pgid; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_site_partner_pgid ON gsf.gsf_page_partner USING btree (page_id);


--
