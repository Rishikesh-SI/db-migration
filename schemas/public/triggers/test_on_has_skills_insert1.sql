-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: test on_has_skills_insert1
-- Type: TRIGGER

-- Name: test on_has_skills_insert1; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_has_skills_insert1 AFTER INSERT OR UPDATE ON public.test FOR EACH ROW EXECUTE FUNCTION public.update_skill_count();


--
