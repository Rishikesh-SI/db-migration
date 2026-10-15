-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_site_partner_pgid
-- Type: INDEX

-- Name: ix_abp_site_partner_pgid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_site_partner_pgid ON abpp.abp_page_partner USING btree (page_id);


--
