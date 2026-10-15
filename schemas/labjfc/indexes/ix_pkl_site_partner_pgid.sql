-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: ix_pkl_site_partner_pgid
-- Type: INDEX

-- Name: ix_pkl_site_partner_pgid; Type: INDEX; Schema: labjfc; Owner: -
--

CREATE INDEX ix_pkl_site_partner_pgid ON labjfc.labjfc_page_partner USING btree (page_id);


--
